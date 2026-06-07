import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';

import { DashboardController } from './dashboard.controller';
import { DashboardService } from './dashboard.service';

import { Book } from '../books/entities/book.entity';
import { Member } from '../members/entities/member.entity';
import { Borrowing } from '../borrowings/entities/borrowing.entity';

@Module({
  imports: [
    TypeOrmModule.forFeature([
      Book,
      Member,
      Borrowing,
    ]),
  ],
  controllers: [DashboardController],
  providers: [DashboardService],
})
export class DashboardModule {}