import {
  Controller,
  Get,
  Post,
  Delete,
  Param,
  Body,
} from '@nestjs/common';

import { MembersService } from './members.service';
import { CreateMemberDto } from './dto/create-member.dto';

@Controller('members')
export class MembersController {

  constructor(
    private readonly membersService: MembersService,
  ) {}

  @Post()
  create(
    @Body() createMemberDto: CreateMemberDto,
  ) {
    return this.membersService.create(
      createMemberDto,
    );
  }

  @Get()
  findAll() {
    return this.membersService.findAll();
  }

  @Get(':id')
  findOne(
    @Param('id') id: string,
  ) {
    return this.membersService.findOne(+id);
  }

  @Delete(':id')
  remove(
    @Param('id') id: string,
  ) {
    return this.membersService.remove(+id);
  }
}